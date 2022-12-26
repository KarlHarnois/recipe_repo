import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as ec2 from "aws-cdk-lib/aws-ec2";
import * as rds from "aws-cdk-lib/aws-rds";
import * as secrets from "aws-cdk-lib/aws-secretsmanager";

export interface PostgresRdsInstanceProps extends cdk.StackProps {
  prefix: string;
  vpc: ec2.Vpc;
  user: string;
  port: number;
  database: string;
  secretName: string;
}

export class PostgresRdsInstance {
  constructor(scope: Construct, props: PostgresRdsInstanceProps) {
    const securityGroup = new ec2.SecurityGroup(scope, `rds-security-group`, {
      vpc: props.vpc
    });

    securityGroup.addIngressRule(
      ec2.Peer.ipv4(props.vpc.vpcCidrBlock),
      ec2.Port.tcp(props.port || 3306),
      "Allows only local resources inside VPC to access this Postgres port (default -- 3306)"
    );

    const secret = new secrets.Secret(
      scope,
      `${props.prefix}-postgres-instance-secrets`,
      {
        secretName: props.secretName,
        description: "Credentials to access Postgres Database on RDS",
        generateSecretString: {
          secretStringTemplate: JSON.stringify({ username: props.user }),
          excludePunctuation: true,
          includeSpace: false,
          generateStringKey: "password"
        }
      }
    );

    new rds.DatabaseInstance(scope, `postgres-instance`, {
      credentials: rds.Credentials.fromSecret(secret),
      engine: rds.DatabaseInstanceEngine.postgres({
        version: rds.PostgresEngineVersion.VER_14_2
      }),
      port: props.port,
      allocatedStorage: 100,
      storageType: rds.StorageType.GP2,
      backupRetention: cdk.Duration.days(7),
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T3,
        ec2.InstanceSize.MICRO
      ),
      vpc: props.vpc,
      vpcSubnets: { subnetType: ec2.SubnetType.PRIVATE_ISOLATED },
      removalPolicy: cdk.RemovalPolicy.SNAPSHOT,
      deletionProtection: true,
      securityGroups: [securityGroup]
    });
  }
}
