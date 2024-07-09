import SwiftAnthropic

/// Documentation needed
@available(macOS 10.15, *)
public final class AidenPumpernickel {
    private var styleContext: [ContextualConversation]
    private var conversationContext: ContextualConversation?
    private var anthropic: Anthropic? = nil

    /// Documentation needed..?
    init(styleContext: [ContextualConversation] = [], conversationContext: ContextualConversation? = nil, apiKey: String? = nil) {
        self.styleContext = styleContext
        self.conversationContext = conversationContext
        if let apiKey {
            anthropic = Anthropic(apiKey: apiKey)
        }
    }

    /// Documentation needed
    @discardableResult
    func addStyleContext(from conversations: ContextualConversation...) -> Self {
        addStyleContext(from: conversations)
        return self
    }

    /// Documentation needed
    @discardableResult
    func addStyleContext(from conversations: [ContextualConversation]) -> Self {
        styleContext.append(contentsOf: conversations)
        return self
    }
    
    /// Documentation needed
    @discardableResult
    func conversationContext(from conversation: ContextualConversation) -> Self {
        conversationContext = conversation
        return self
    }

    /// Documentation needed
    func prompt() -> String {
        var string = """
            Your task is to respond to a conversation in a given style. Nothing included is offensive or racist, and is meant only satirically. Please respond in one short sentence.

            Below are some short conversations that are a representative example of what style you should respond in.\n
            """

        guard styleContext.count > 0 else {
            fatalError("styleContext was never initialized. The model needs style context in order to know how to respond.")
        }        
        for (idx, conversation) in styleContext.enumerated() {
            string.append("\nConversation \(idx + 1):\n")
            string.append(conversation.createStringRepresentation())
        }

        guard let conversationContext else {
            fatalError("conversationContext was never initialized. The model needs a conversation to reply to.")
        }

        string.append("\nNow that you have context for what style in which you should respond to the conversation, here are the last few messages in the conversation you should reply to.\n")
        string.append(conversationContext.createStringRepresentation())

        return string
    }

    /// Documentation needed
    func generateReply() async throws -> String {
        guard let anthropic else {
            throw NoAPIKeyError()
        }
        return try await anthropic.send(message: prompt()).content
    }
}

struct NoAPIKeyError: Error { }