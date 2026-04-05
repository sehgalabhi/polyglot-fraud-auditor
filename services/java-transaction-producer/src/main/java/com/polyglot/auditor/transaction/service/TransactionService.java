package com.polyglot.auditor.transaction.service;

import com.polyglot.auditor.transaction.messaging.TransactionEventPublisher;
import com.polyglot.auditor.transaction.model.CreateTransactionRequest;
import com.polyglot.auditor.transaction.model.CreateTransactionResponse;
import com.polyglot.auditor.transaction.model.TransactionEventPayload;
import java.util.UUID;
import org.springframework.stereotype.Service;

@Service
public class TransactionService {

    private final TransactionEventPublisher eventPublisher;

    public TransactionService(TransactionEventPublisher eventPublisher) {
        this.eventPublisher = eventPublisher;
    }

    public CreateTransactionResponse createPending(CreateTransactionRequest request) {
        String id = UUID.randomUUID().toString();
        // Persistence hook: replace with JPA / JDBC in a later iteration.
        eventPublisher.publish(
                new TransactionEventPayload(
                        id,
                        request.userId(),
                        request.amount(),
                        request.currency(),
                        request.memo() != null ? request.memo() : "",
                        "PENDING_AUDIT"));
        return new CreateTransactionResponse(id, "PENDING_AUDIT");
    }

    public void applyAuditDecision(String transactionId, String decision, String reasoning) {
        // Persistence hook: load row, validate state, update from agent callback.
    }
}
