package dev.danvega.chatgpt;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class UserController {



    @GetMapping("/users")
    public Map<String, Integer> getUsers() {
        return Map.of("Ali", 20, "Toxir", 22);
    }
}
