package com.polyglot.auditor.transaction;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class TransactionEngineApplicationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void createTransaction_returnsAccepted() throws Exception {
        mockMvc.perform(
                        post("/api/v1/transactions")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(
                                        """
                                        {
                                          "userId": "user-1",
                                          "amount": 5000.00,
                                          "currency": "USD",
                                          "memo": "Wire transfer"
                                        }
                                        """))
                .andExpect(status().isAccepted())
                .andExpect(jsonPath("$.status").value("PENDING_AUDIT"))
                .andExpect(jsonPath("$.transactionId").exists());
    }
}
