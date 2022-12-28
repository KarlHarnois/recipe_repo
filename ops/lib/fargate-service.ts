import * as cdk from "aws-cdk-lib";
import * as secrets from "aws-cdk-lib/aws-secretsmanager";
import * as ecs from "aws-cdk-lib/aws-ecs";
import * as iam from "aws-cdk-lib/aws-iam";
import * as ec2 from "aws-cdk-lib/aws-ec2";
import * as ecrAssets from "aws-cdk-lib/aws-ecr-assets";
import * as ecsPatterns from "aws-cdk-lib/aws-ecs-patterns";
import { Construct } from "constructs";
import { join } from "path";

export interface FargateServiceProps extends cdk.StackProps {
  databaseSecret: secrets.Secret;
  prefix: string;
  vpc: ec2.Vpc;
}

export class FargateService {
  constructor(scope: Construct, props: FargateServiceProps) {
    const image = new ecrAssets.DockerImageAsset(
      scope,
      `${props.prefix}-image`,
      {
        directory: join(__dirname, "../.."),
        file: "Dockerfile"
      }
    );

    const cluster = new ecs.Cluster(scope, `cluster`, {
      vpc: props.vpc
    });

    new ecsPatterns.ApplicationLoadBalancedFargateService(
      scope,
      `${props.prefix}-application-fargate-service`,
      {
        cluster: cluster,
        cpu: 256,
        desiredCount: 1,
        publicLoadBalancer: true,
        assignPublicIp: true,
        taskImageOptions: {
          image: ecs.ContainerImage.fromDockerImageAsset(image),
          containerPort: 9292,
          taskRole: this.createEcsTaskRole(scope, props),
          executionRole: this.createEcsExecutionRole(scope, props),
          secrets: {
            POSTGRES_USER: this.databaseSecret(props, "username"),
            POSTGRES_PASSWORD: this.databaseSecret(props, "password"),
            POSTGRES_HOST: this.databaseSecret(props, "host"),
            POSTGRES_PORT: this.databaseSecret(props, "port")
          }
        },
        memoryLimitMiB: 512
      }
    );
  }

  private createEcsExecutionRole(
    scope: Construct,
    props: FargateServiceProps
  ): iam.IRole {
    const ecsExecutionRole = new iam.Role(scope, "ecs-execution-role", {
      assumedBy: new iam.ServicePrincipal("ecs-tasks.amazonaws.com"),
      roleName: `${props.prefix}-ecs-execution-role`
    });
    ecsExecutionRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName(
        "AmazonEC2ContainerRegistryReadOnly"
      )
    );
    ecsExecutionRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("CloudWatchLogsFullAccess")
    );
    return ecsExecutionRole;
  }

  private createEcsTaskRole(
    scope: Construct,
    props: FargateServiceProps
  ): iam.IRole {
    const ecsTaskRole = new iam.Role(scope, "recipe-repo-ecs-task-role", {
      assumedBy: new iam.ServicePrincipal("ecs-tasks.amazonaws.com"),
      roleName: `${props.prefix}-recipe-repo-ecs-task-role`
    });

    ecsTaskRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName(
        "AmazonEC2ContainerRegistryReadOnly"
      )
    );
    ecsTaskRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("CloudWatchLogsFullAccess")
    );
    ecsTaskRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("AmazonS3ReadOnlyAccess")
    );

    return ecsTaskRole;
  }

  private databaseSecret(props: FargateServiceProps, key: string): ecs.Secret {
    return ecs.Secret.fromSecretsManager(props.databaseSecret, key);
  }
}
