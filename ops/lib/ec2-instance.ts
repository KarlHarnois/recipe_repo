import * as cdk from "aws-cdk-lib";
import * as ec2 from "aws-cdk-lib/aws-ec2";
import * as iam from "aws-cdk-lib/aws-iam";
import { Construct } from "constructs";

interface EC2InstanceProps {
  prefix: string;
  vpc: ec2.IVpc;
}

export class EC2Instance {
  constructor(scope: Construct, props: EC2InstanceProps) {
    const role = new iam.Role(scope, `${props.prefix}-ec2-instance-role`, {
      assumedBy: new iam.ServicePrincipal("ec2.amazonaws.com"),
      managedPolicies: [
        iam.ManagedPolicy.fromAwsManagedPolicyName(
          "AmazonSSMManagedInstanceCore"
        ),
        iam.ManagedPolicy.fromAwsManagedPolicyName("SecretsManagerReadWrite")
      ]
    });

    const securityGroup = new ec2.SecurityGroup(
      scope,
      `ec2-instance-security-group`,
      {
        vpc: props.vpc,
        allowAllOutbound: true
      }
    );

    securityGroup.addIngressRule(
      ec2.Peer.anyIpv4(),
      ec2.Port.tcp(22),
      "Allows SSH access from Internet"
    );

    securityGroup.addIngressRule(
      ec2.Peer.anyIpv4(),
      ec2.Port.tcp(80),
      "Allows HTTP access from Internet"
    );

    securityGroup.addIngressRule(
      ec2.Peer.anyIpv4(),
      ec2.Port.tcp(443),
      "Allows HTTPS access from Internet"
    );

    const instance = new ec2.Instance(scope, `${props.prefix}-ec2-instance`, {
      vpc: props.vpc,
      role: role,
      securityGroup: securityGroup,
      instanceName: `${props.prefix}-ec2-instance`,
      keyName: `${props.prefix}-ec2-ssh-key`,
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T2,
        ec2.InstanceSize.MICRO
      ),
      machineImage: ec2.MachineImage.latestAmazonLinux(),
      vpcSubnets: {
        subnetType: ec2.SubnetType.PUBLIC
      }
    });

    new cdk.CfnOutput(scope, `${props.prefix}-ec2-instance-output`, {
      value: instance.instancePublicIp
    });
  }
}
