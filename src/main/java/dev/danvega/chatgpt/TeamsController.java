package dev.danvega.chatgpt;


import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TeamsController {


    private final ChatClient chatClient;

    public TeamsController(ChatClient.Builder builder) {
        this.chatClient = builder
                .defaultOptions(OpenAiChatOptions.builder()
                        .withTemperature(0.0f)
                        .build())
                .build();
    }


    @GetMapping("/teams")
    public List<NbaTeam> teams() {
        return chatClient.prompt()
                .user("Please name all of the teams in the NBA.")
                .call()
                .entity(new ParameterizedTypeReference<List<NbaTeam>>() {
                });
    }
}
