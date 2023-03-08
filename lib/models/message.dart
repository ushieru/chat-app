class Message {
  Message(this.from, this.username, this.to, this.message);

  String from;
  String to;
  String message;
  String username;

  @override
  String toString() {
    return 'Message(from: $from, to: $to, username: $username, message: $message)';
  }
}
