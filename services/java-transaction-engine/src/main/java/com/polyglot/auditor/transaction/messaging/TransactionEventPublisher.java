package com.polyglot.auditor.transaction.messaging;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.polyglot.auditor.transaction.model.TransactionEventPayload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;

@Component
public class TransactionEventPublisher {

    private static final Logger log = LoggerFactory.getLogger(TransactionEventPublisher.class);

    private final SqsClient sqsClient;
    private final ObjectMapper objectMapper;
    private final String queueUrl;

    public TransactionEventPublisher(
            SqsClient sqsClient,
            ObjectMapper objectMapper,
            @Value("${app.sqs.transaction-events-url:}") String queueUrl) {
        this.sqsClient = sqsClient;
        this.objectMapper = objectMapper;
        this.queueUrl = queueUrl;
    }

    public void publish(TransactionEventPayload payload) {
        if (queueUrl == null || queueUrl.isBlank()) {
            log.warn("app.sqs.transaction-events-url not set; skipping SQS publish for transactionId={}", payload.transactionId());
            return;
        }
        try {
            String body = objectMapper.writeValueAsString(payload);
            sqsClient.sendMessage(
                    SendMessageRequest.builder().queueUrl(queueUrl).messageBody(body).build());
            log.debug("Published transaction event {}", payload.transactionId());
        } catch (JsonProcessingException e) {
            throw new IllegalStateException("Failed to serialize transaction event", e);
        }
    }
}
