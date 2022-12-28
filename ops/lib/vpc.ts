import * as cdk from "aws-cdk-lib";
import * as ec2 from "aws-cdk-lib/aws-ec2";
import { Construct } from "constructs";

export interface VpcProps extends cdk.StackProps {
  prefix: string;
}

export class Vpc {
  public readonly instance: ec2.Vpc;

  constructor(scope: Construct, props: VpcProps) {
    this.instance = new ec2.Vpc(scope, `${props.prefix}-vpc`, {
      maxAzs: 2,
      enableDnsHostnames: true,
      enableDnsSupport: true,
      natGateways: 0,
      subnetConfiguration: [
        {
          cidrMask: 22,
          name: `${props.prefix}-public-`,
          subnetType: ec2.SubnetType.PUBLIC
        },
        {
          cidrMask: 22,
          name: `${props.prefix}-isolated-`,
          subnetType: ec2.SubnetType.PRIVATE_ISOLATED
        }
      ]
    });

    this.setupInterfaceVpcEndpoints();
  }

  private setupInterfaceVpcEndpoints(): void {
    this.addInterfaceEndpoint(
      "ECRDockerEndpoint",
      ec2.InterfaceVpcEndpointAwsService.ECR_DOCKER
    );

    this.addInterfaceEndpoint(
      "ECREndpoint",
      ec2.InterfaceVpcEndpointAwsService.ECR
    );

    this.addInterfaceEndpoint(
      "SecretManagerEndpoint",
      ec2.InterfaceVpcEndpointAwsService.SECRETS_MANAGER
    );

    this.addInterfaceEndpoint(
      "CloudWatchEndpoint",
      ec2.InterfaceVpcEndpointAwsService.CLOUDWATCH
    );

    this.addInterfaceEndpoint(
      "CloudWatchLogsEndpoint",
      ec2.InterfaceVpcEndpointAwsService.CLOUDWATCH_LOGS
    );

    this.addInterfaceEndpoint(
      "CloudWatchEventsEndpoint",
      ec2.InterfaceVpcEndpointAwsService.CLOUDWATCH_EVENTS
    );

    this.addInterfaceEndpoint(
      "SSMEndpoint",
      ec2.InterfaceVpcEndpointAwsService.SSM
    );
  }

  private addInterfaceEndpoint(
    name: string,
    awsService: ec2.InterfaceVpcEndpointAwsService
  ): void {
    const endpoint: ec2.InterfaceVpcEndpoint = this.instance.addInterfaceEndpoint(
      `${name}`,
      {
        service: awsService
      }
    );

    endpoint.connections.allowFrom(
      ec2.Peer.ipv4(this.instance.vpcCidrBlock),
      endpoint.connections.defaultPort!
    );
  }
}
