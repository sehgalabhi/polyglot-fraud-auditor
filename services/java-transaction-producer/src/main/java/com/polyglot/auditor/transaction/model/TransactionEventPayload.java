package com.polyglot.auditor.transaction.model;

import java.math.BigDecimal;

/**
 * Transaction event contract.
 */
public record TransactionEventPayload(
        String transactionId,
        String userId,
        BigDecimal amount,
        String currency,
        String memo,
        String status) {}
