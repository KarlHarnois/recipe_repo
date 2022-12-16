#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { RecipeRepoStack } from '../lib/recipe-repo-stack';

const app = new cdk.App();

new RecipeRepoStack(app, 'RecipeRepoStack', {
});
