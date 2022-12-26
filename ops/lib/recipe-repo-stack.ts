import { Vpc } from "./vpc";
import { PostgresRdsInstance } from "./postgres-rds-instance";
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
      prefix: props.projectName
    });

    new PostgresRdsInstance(this, {
      prefix: props.projectName,
      vpc: vpc.instance,
      user: `recipeRepoAdmin`,
      database: `${props.projectName}-database`,
      port: 3306,
      secretName: `${props.projectName}/rds/postgres/credentials`
    });

    const ec2 = new EC2Instance(this, {
      prefix: props.projectName,
      vpc: vpc.instance
    });
  }
}
