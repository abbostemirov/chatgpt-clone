package dev.danvega.chatgpt;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {



    @GetMapping("/health")
    public String test() {
        return "UP";
    }


}
