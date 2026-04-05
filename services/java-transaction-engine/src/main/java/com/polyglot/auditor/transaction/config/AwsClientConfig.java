package com.polyglot.auditor.transaction.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.sqs.SqsClient;

@Configuration
public class AwsClientConfig {

    @Bean
    public SqsClient sqsClient(
            @Value("${app.aws.region:us-east-1}") String region,
            @Value("${app.aws.endpoint:}") String endpointOverride) {
        var builder = SqsClient.builder().region(Region.of(region));
        if (endpointOverride != null && !endpointOverride.isBlank()) {
            builder = builder.endpointOverride(java.net.URI.create(endpointOverride));
        }
        return builder.build();
    }
}
