#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { DeployStack } from "../lib/deploy-stack";

const serviceName = "_______";
const app = new cdk.App();

new DeployStack("_____", "____", {
  env: {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
  },
});
