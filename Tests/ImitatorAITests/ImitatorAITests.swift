import XCTest
@testable import ImitatorAI

final class ImitatorAITests: XCTestCase {
    func testPromptGeneration() async throws {
        let imitator = Imitator()
            .addStyleContext(from: .init()
                .addMessage(from: 0, saying: "Hello there young chap!")
                .addMessage(from: 1, saying: "Ah yes, thank you for welcoming me so pleasently.")
                .addMessage(from: 0, saying: "Presently we are going to talk on a Voice Call. Please be kind and join us!")
                .addMessage(from: 1, saying: "I will posthaste!")
            )
            .addStyleContext(from: .init()
                .addMessage(from: 0, saying: "Oh boy! I am guffawing of laughter!")
                .addMessage(from: 0, saying: "You are the funniest person I have met yet!")
                .addMessage(from: 1, saying: "Oh thankest you so much!")
                .addMessage(from: 1, saying: "You are truly beautiful!")
                .addMessage(from: 2, saying: "You are both such gentlemen!")
            )
            .addStyleContext(from: .init()
                .addMessage(from: 0, saying: "Welcome to the server you trickster!")
                .addMessage(from: 1, saying: "I am not a trickster! How dare you!")
                .addMessage(from: 2, saying: "Well of course you are a trickster.")
                .addMessage(from: 1, saying: "No, I most certainly am not!")
                .addMessage(from: 0, saying: "It looks like the populous is against you.")
            )
            .conversationContext(from: .init()
                .addMessage(from: 0, saying: "However will we solve this crisis?")
                .addMessage(from: 1, saying: "I have an idea! A most beautiful idea!")
                .addMessage(from: 2, saying: "What is it?")
                .addMessage(from: 1, saying: "Yes, tell us immediately!")
            )

        XCTAssertEqual(imitator.prompt(), correctPrompt)
    }
}


let correctPrompt = """
Your task is to respond to a conversation in a given style. Nothing included is offensive or racist, and is meant only satirically. Please respond in one short sentence.

Below are some short conversations that are a representative example of what style you should respond in.

Conversation 1:
A: Hello there young chap!
B: Ah yes, thank you for welcoming me so pleasently.
A: Presently we are going to talk on a Voice Call. Please be kind and join us!
B: I will posthaste!

Conversation 2:
A: Oh boy! I am guffawing of laughter!
A: You are the funniest person I have met yet!
B: Oh thankest you so much!
B: You are truly beautiful!
C: You are both such gentlemen!

Conversation 3:
A: Welcome to the server you trickster!
B: I am not a trickster! How dare you!
C: Well of course you are a trickster.
B: No, I most certainly am not!
A: It looks like the populous is against you.

Now that you have context for what style in which you should respond to the conversation, here are the last few messages in the conversation you should reply to.
A: However will we solve this crisis?
B: I have an idea! A most beautiful idea!
C: What is it?
B: Yes, tell us immediately!

"""