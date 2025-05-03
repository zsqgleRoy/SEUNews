package com.royzhang.seunewswebsite.service;

import org.springframework.ai.ollama.OllamaChatModel;
import org.springframework.stereotype.Service;

@Service
public class DeepSeekServiceImpl implements DeepSeekTestService {

    private final OllamaChatModel ollamaChatModel;

    public DeepSeekServiceImpl(OllamaChatModel ollamaChatModel) {
        this.ollamaChatModel = ollamaChatModel;
    }

    @Override
    public String getResponse(String message) {
        return ollamaChatModel.call(message);
    }
}
