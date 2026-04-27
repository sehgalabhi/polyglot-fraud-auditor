package com.polyglot.auditor.transaction.messaging;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.polyglot.auditor.transaction.model.TransactionEventPayload;
import java.math.BigDecimal;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;

@ExtendWith(MockitoExtension.class)
class TransactionEventPublisherTest {

    @Mock
    private SqsClient sqsClient;

    @Test
    void publish_sendsSerializedPayloadToConfiguredQueue() {
        var queueUrl = "https://sqs.us-east-1.amazonaws.com/123456789012/transaction-events";
        var publisher = new TransactionEventPublisher(sqsClient, new ObjectMapper(), queueUrl);
        publisher.publish(
                new TransactionEventPayload(
                        "tx-1",
                        "user-1",
                        new BigDecimal("100.00"),
                        "USD",
                        "Card payment",
                        "PENDING_AUDIT"));

        var requestCaptor = ArgumentCaptor.forClass(SendMessageRequest.class);
        verify(sqsClient).sendMessage(requestCaptor.capture());
        SendMessageRequest request = requestCaptor.getValue();
        assertEquals(queueUrl, request.queueUrl());
        assertTrue(request.messageBody().contains("\"transactionId\":\"tx-1\""));
        assertTrue(request.messageBody().contains("\"status\":\"PENDING_AUDIT\""));
    }
}
