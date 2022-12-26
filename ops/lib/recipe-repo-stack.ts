import { Vpc } from "./vpc";
import { PostgresRdsInstance } from "./postgres-rds-instance";
import { LoadBalancer } from "./load-balancer";
import { EC2Instance } from "./ec2-instance";
import { Construct } from "constructs";
import { StackProps, Stack } from "aws-cdk-lib";

export interface RecipeRepoStackProps extends StackProps {
  projectName: string;
}

export class RecipeRepoStack extends Stack {
  constructor(scope: Construct, id: string, props: RecipeRepoStackProps) {
    super(scope, id, props);

    const vpc = new Vpc(this, {
      prefix: props.projectName,
      cidr: "172.22.0.0/16"
    });

    // new PostgresRdsInstance(this, {
    //   prefix: props.projectName,
    //   vpc: vpc,
    //   user: "admin",
    //   database: `${props.projectName}-database`,
    //   port: 3306,
    //   secretName: `${props.projectName}/rds/postgres/credentials`
    // });

    const ec2 = new EC2Instance(this, {
      prefix: props.projectName,
      vpc: vpc.instance
    });
  }
}
