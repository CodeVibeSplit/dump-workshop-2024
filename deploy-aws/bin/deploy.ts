#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { DeployStack } from '../lib/deploy-stack';

const serviceName = '_____'
const app = new cdk.App();

// Add deploy stack and additionally define account and region (in "env" object, check "StackProps" interface, values -> account: process.env.CDK_DEFAULT_ACCOUNT, region: process.env.CDK_DEFAULT_REGION)

