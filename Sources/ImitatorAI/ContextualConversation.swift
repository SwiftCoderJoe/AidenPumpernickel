/// Represents a conversation and its authors.
/// 
/// `ContextualConversation` will keep track of all messages sent in a conversation and who sent them.
/// The exact type that is provided for each author is irrelevant—each author is only described using a
/// simple "A said B said" dialogue structure.
public class ContextualConversation {
    private var messages: [ContextualMessage] = []
    private var authors: [Int: String] = [:]
    private var numberOfAuthors = 0

    /// Create a conversation with no messages.
    public init() { }

    /// Add a single message to the conversation.
    ///
    /// The exact type that is provided for each author is irrelevant—each author is only described using a
    /// simple "A said B said" dialogue structure. 
    @discardableResult
    public func addMessage<T: Hashable>(from author: T, saying content: String) -> Self {
        if !authors.contains(where: { (key, _) in key == author.hashValue}) {
            authors[author.hashValue] = authorCodes[numberOfAuthors]
            numberOfAuthors += 1
        }

        guard let authorCode = authors[author.hashValue] else {
            fatalError("Could not find an author code for author \(author)")
        }

        messages.append(ContextualMessage(author: authorCode, content: content))

        return self
    }

    /// A string representation of this conversation, including authors, and a trailing newline.
    /// 
    /// The output of this function looks like this:
    /// `A: Welcome to the jungle!\nB: Why am I in the Jungle?\n`
    func createStringRepresentation() -> String {
        var string = ""
        for message in messages {
            string.append("\(message.author): \(message.content)\n")
        }
        return string
    }
}

/// A set of letters to represent each numbered author of messages.
/// 
/// It contains only 16 author codes, but realistically if we need more than that we have bigger issues.
let authorCodes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"]
