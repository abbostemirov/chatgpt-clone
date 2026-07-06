package dev.danvega.chatgpt;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@RestController
public class UserController {


    private final ConcurrentHashMap<String, Integer> users = new ConcurrentHashMap<>();

    public UserController() {
        users.put("Ali", 20);
        users.put("Vali", 22);
    }

    @GetMapping("/users")
    public Map<String, Integer> getUsers() {
        return users;
    }





}
