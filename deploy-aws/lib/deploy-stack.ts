import { RemovalPolicy, Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { BlockPublicAccess, Bucket, BucketAccessControl, BucketEncryption } from 'aws-cdk-lib/aws-s3';
import { BucketDeployment, Source } from 'aws-cdk-lib/aws-s3-deployment';
import * as cdk from 'aws-cdk-lib';
import { Distribution, AllowedMethods, ViewerProtocolPolicy, SecurityPolicyProtocol } from "aws-cdk-lib/aws-cloudfront";
import { S3Origin } from "aws-cdk-lib/aws-cloudfront-origins";

export class DeployStack extends Stack {
  private cfnOutCloudFrontUrl: cdk.CfnOutput;

  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);
    
    // Site bucket
    const siteBucket = new Bucket(this, `________-bucket-dump-radionica`, {
      websiteIndexDocument: '________',
      websiteErrorDocument: '________',
      removalPolicy: RemovalPolicy.DESTROY,
      bucketName: `________-bucket-dump-radionica`,
      publicReadAccess: true,
      encryption: BucketEncryption.S3_MANAGED,
      autoDeleteObjects: true,
      blockPublicAccess: BlockPublicAccess.BLOCK_ACLS,
      accessControl: BucketAccessControl.BUCKET_OWNER_FULL_CONTROL,
    })

    // CloudFront distribution for web hosting
    const distribution = new Distribution(this, `${id}-dump-web-distribution`, {
      defaultBehavior: {
        allowedMethods: AllowedMethods.ALLOW_GET_HEAD_OPTIONS,
        compress: true,
        origin: new S3Origin('________'),
        viewerProtocolPolicy: ViewerProtocolPolicy.REDIRECT_TO_HTTPS,
      },
      defaultRootObject: "________",
      errorResponses: [
        {
          httpStatus: 403,
          responseHttpStatus: 403,
          responsePagePath: "________",
          ttl: cdk.Duration.minutes(30),
        },
      ],
      minimumProtocolVersion: SecurityPolicyProtocol.TLS_V1_2_2019,
    });

    // Static Code in to Bucket.
    new BucketDeployment(
      this,
      `${id}-deploy`,
      {
        sources: [Source.asset('________')],
        destinationBucket: '________',
      }
    );  

    this.cfnOutCloudFrontUrl = new cdk.CfnOutput(this, "CfnOutCloudFrontUrl", {
      value: `https://${______________________}`,
      description: "The CloudFront URL",
    });
    
  }
}
