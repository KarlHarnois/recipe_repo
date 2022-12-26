import * as ec2 from "aws-cdk-lib/aws-ec2";
import { Construct } from "constructs";

export interface VpcProps {
  prefix: string;
  cidr: string;
}

export class Vpc {
  public readonly instance: ec2.Vpc;

  constructor(scope: Construct, props: VpcProps) {
    this.instance = new ec2.Vpc(scope, `${props.prefix}-vpc`, {
      maxAzs: 2,
      cidr: props.cidr,
      enableDnsHostnames: true,
      enableDnsSupport: true,
      natGateways: 0,
      subnetConfiguration: [
        {
          cidrMask: 22,
          name: `${props.prefix}-public-`,
          subnetType: ec2.SubnetType.PUBLIC
        }
        // {
        //   cidrMask: 22,
        //   name: `${props.prefix}-isolated-`,
        //   subnetType: ec2.SubnetType.PRIVATE_ISOLATED
        // }
      ]
    });
  }
}
