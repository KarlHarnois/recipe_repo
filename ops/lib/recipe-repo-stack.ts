import * as cdk from "aws-cdk-lib";
import { Vpc } from "./vpc";
import { PostgresRdsInstance } from "./postgres-rds-instance";
import { EC2Instance } from "./ec2-instance";
import { FargateService } from "./fargate-service";
import { Construct } from "constructs";

export interface RecipeRepoStackProps extends cdk.StackProps {
  projectName: string;
}

export class RecipeRepoStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props: RecipeRepoStackProps) {
    super(scope, id, props);

    const vpc = new Vpc(this, {
      prefix: props.projectName
    });

    const postgres = new PostgresRdsInstance(this, {
      prefix: props.projectName,
      vpc: vpc.instance,
      username: "recipe_repo_admin",
      database: `${props.projectName}-database`,
      port: 3306,
      secretName: `${props.projectName}/rds/postgres/credentials`
    });

    new FargateService(this, {
      databaseSecret: postgres.secret,
      prefix: props.projectName,
      vpc: vpc.instance
    });
  }
}
