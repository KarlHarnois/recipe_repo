import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as ec2 from "aws-cdk-lib/aws-ec2";
import * as elbv2 from "aws-cdk-lib/aws-elasticloadbalancingv2";

export interface LoadBalancerProps extends cdk.StackProps {
  prefix: string;
  vpc: ec2.IVpc;
}

export class LoadBalancer {
  public readonly dnsName: string;

  private readonly listener: elbv2.IApplicationListener;

  constructor(scope: Construct, props: LoadBalancerProps) {
    const loadBalancer = new elbv2.ApplicationLoadBalancer(
      scope,
      `${props.prefix}-load-balancer`,
      {
        loadBalancerName: `${props.prefix}-load-balancer`,
        vpc: props.vpc,
        internetFacing: true
      }
    );

    this.dnsName = loadBalancer.loadBalancerDnsName;

    this.listener = loadBalancer.addListener(
      `${props.prefix}-load-balancer-listener`,
      {
        port: 80,
        open: true
      }
    );

    new cdk.CfnOutput(scope, `${props.prefix}-load-balancer-dns-name`, {
      value: loadBalancer.loadBalancerDnsName
    });
  }
}
