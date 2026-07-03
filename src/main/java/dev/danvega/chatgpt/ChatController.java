package dev.danvega.chatgpt;


import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.MessageChatMemoryAdvisor;
import org.springframework.ai.chat.memory.InMemoryChatMemory;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ChatController {


    private final ChatClient chatClient;

    public ChatController(ChatClient.Builder builder) {
        this.chatClient = builder
                .defaultAdvisors(new MessageChatMemoryAdvisor(new InMemoryChatMemory()))
                .build();
    }

    @GetMapping("/chat")
    public ChatResponse chat(@RequestParam(required = false, defaultValue = "Write the code Spring AI") String userMsg) {

        OpenAiChatOptions options = OpenAiChatOptions.builder()
                .withTemperature(0.0f)
                .build();

        return chatClient.prompt()
                .user(userMsg)
                .call()
                .chatResponse();

    }
}
