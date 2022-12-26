import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as ec2 from "aws-cdk-lib/aws-ec2";
import * as rds from "aws-cdk-lib/aws-rds";
import * as secrets from "aws-cdk-lib/aws-secretsmanager";

export interface PostgresRdsInstanceProps {
  prefix: string;
  vpc: ec2.Vpc;
  user: string;
  port: number;
  database: string;
  secretName: string;
}

export class PostgresRdsInstance {
  private scope: Construct;
  private props: PostgresRdsInstanceProps;

  constructor(scope: Construct, props: PostgresRdsInstanceProps) {
    this.scope = scope;
    this.props = props;

    const securityGroup = this.createSecurityGroup();
    const secret = this.createSecret();
    this.createDatabaseInstance({ secret, securityGroup });
  }

  private createSecurityGroup(): ec2.SecurityGroup {
    const ingressSecurityGroup = new ec2.SecurityGroup(
      this.scope,
      `${this.props.prefix}-rds-ingress`,
      {
        vpc: this.props.vpc,
        securityGroupName: `${this.props.prefix}-rds-ingress-sg`
      }
    );

    ingressSecurityGroup.addIngressRule(
      ec2.Peer.ipv4(this.props.vpc.vpcCidrBlock),
      ec2.Port.tcp(this.props.port || 3306),
      "Allows only local resources inside VPC to access this Postgres port (default -- 3306)"
    );

    return ingressSecurityGroup;
  }

  private createSecret(): secrets.Secret {
    return new secrets.Secret(
      this.scope,
      `${this.props.prefix}-postgres-instance-secrets`,
      {
        secretName: this.props.secretName,
        description: "Credentials to access Postgres Database on RDS",
        generateSecretString: {
          secretStringTemplate: JSON.stringify({ username: this.props.user }),
          excludePunctuation: true,
          includeSpace: false,
          generateStringKey: "password"
        }
      }
    );
  }

  private createDatabaseInstance({
    secret,
    securityGroup
  }: {
    secret: secrets.Secret;
    securityGroup: ec2.SecurityGroup;
  }): rds.DatabaseInstance {
    return new rds.DatabaseInstance(
      this.scope,
      `${this.props.prefix}-postgres-instance`,
      {
        credentials: rds.Credentials.fromSecret(secret),
        engine: rds.DatabaseInstanceEngine.postgres({
          version: rds.PostgresEngineVersion.VER_14_2
        }),
        port: this.props.port,
        allocatedStorage: 100,
        storageType: rds.StorageType.GP2,
        backupRetention: cdk.Duration.days(7),
        instanceType: ec2.InstanceType.of(
          ec2.InstanceClass.T2,
          ec2.InstanceSize.MICRO
        ),
        vpc: this.props.vpc,
        vpcSubnets: { subnetType: ec2.SubnetType.PRIVATE_ISOLATED },
        removalPolicy: cdk.RemovalPolicy.SNAPSHOT,
        deletionProtection: true,
        securityGroups: [securityGroup]
      }
    );
  }
}
