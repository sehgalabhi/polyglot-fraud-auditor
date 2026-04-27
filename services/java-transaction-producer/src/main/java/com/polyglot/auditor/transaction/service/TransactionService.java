package com.polyglot.auditor.transaction.service;

import com.polyglot.auditor.transaction.messaging.TransactionEventPublisher;
import com.polyglot.auditor.transaction.model.CreateTransactionRequest;
import com.polyglot.auditor.transaction.model.CreateTransactionResponse;
import com.polyglot.auditor.transaction.model.TransactionEventPayload;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class TransactionService {

    private static final Logger log = LoggerFactory.getLogger(TransactionService.class);
    private static final String PENDING_AUDIT = "PENDING_AUDIT";

    private final TransactionEventPublisher eventPublisher;

    public TransactionService(TransactionEventPublisher eventPublisher) {
        this.eventPublisher = eventPublisher;
    }

    public CreateTransactionResponse createPending(CreateTransactionRequest request) {
        String id = UUID.randomUUID().toString();
        TransactionEventPayload payload =
                new TransactionEventPayload(
                        id,
                        request.userId(),
                        request.amount(),
                        request.currency(),
                        request.memo() != null ? request.memo() : "",
                        PENDING_AUDIT);
        // Event-first flow: persist transaction state in the service data layer if needed.
        eventPublisher.publish(payload);
        log.info("Transaction {} submitted with status {}", id, PENDING_AUDIT);
        return new CreateTransactionResponse(id, PENDING_AUDIT);
    }

}
