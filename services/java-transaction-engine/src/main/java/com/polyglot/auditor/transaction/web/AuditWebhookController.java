package com.polyglot.auditor.transaction.web;

import com.polyglot.auditor.transaction.model.AuditCallbackRequest;
import com.polyglot.auditor.transaction.service.TransactionService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/internal/v1/agent")
public class AuditWebhookController {

    private final TransactionService transactionService;

    public AuditWebhookController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @PostMapping("/audit-callback")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void auditCallback(
            @RequestHeader(value = "X-Agent-Secret", required = false) String secret,
            @Valid @RequestBody AuditCallbackRequest body) {
        // Validate shared secret in a later iteration (e.g. Spring Security filter).
        transactionService.applyAuditDecision(body.transactionId(), body.decision(), body.reasoning());
    }
}
