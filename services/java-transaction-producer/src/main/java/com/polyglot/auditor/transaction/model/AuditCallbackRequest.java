package com.polyglot.auditor.transaction.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record AuditCallbackRequest(
        @NotBlank @Size(max = 64) String transactionId,
        @NotBlank
                @Pattern(regexp = "APPROVED|DENIED|REVIEW", message = "decision must be APPROVED, DENIED, or REVIEW")
                String decision,
        @Size(max = 4000) String reasoning) {}
