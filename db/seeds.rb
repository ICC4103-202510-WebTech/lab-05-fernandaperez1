Message.destroy_all
ChatUser.destroy_all
Chat.destroy_all
User.destroy_all

admin = User.create!(
  first_name: "Fer",
  last_name: "Nanda",
  email: "fer@webtech.com",
  password: "admin123",
  admin: true
)

users = {
  mario:     User.create!(first_name: "Mario",     last_name: "Bros",      email: "mario@webtech.com",     password: "123456"),
  luigi:     User.create!(first_name: "Luigi",     last_name: "Bros",      email: "luigi@webtech.com",     password: "123456"),
  donkey:    User.create!(first_name: "Donkey",    last_name: "Kong",      email: "donkey@webtech.com",    password: "123456"),
  kirby:     User.create!(first_name: "Kirby",     last_name: "Estrella",  email: "kirby@webtech.com",     password: "123456"),
  link:      User.create!(first_name: "Link",      last_name: "De Hyrule", email: "link@webtech.com",      password: "123456"),
  inkling:   User.create!(first_name: "Inkling",   last_name: "Verde",     email: "inkling@webtech.com",   password: "123456"),
  octoling:  User.create!(first_name: "Octoling",  last_name: "Rosa",      email: "octoling@webtech.com",  password: "123456")
}

chat1 = Chat.create!(sender: users[:mario], receiver: users[:luigi])
Message.create!(chat: chat1, sender: users[:mario], recipient: users[:luigi], body: "Ayudame Luigi")
Message.create!(chat: chat1, sender: users[:luigi], recipient: users[:mario], body: "Que te paso hermano?")

chat2 = Chat.create!(sender: users[:donkey], receiver: users[:kirby])
Message.create!(chat: chat2, sender: users[:donkey], recipient: users[:kirby], body: "Kirby, de nuevo me robaste los platanos???")
Message.create!(chat: chat2, sender: users[:kirby], recipient: users[:donkey], body: "Poyo!")

chat3 = Chat.create!(sender: users[:link], receiver: users[:inkling])
Message.create!(chat: chat3, sender: users[:link], recipient: users[:inkling], body: "¡Aghhh!")
Message.create!(chat: chat3, sender: users[:inkling], recipient: users[:link], body: "...otra vez este ****")

chat4 = Chat.create!(sender: users[:octoling], receiver: users[:kirby])
Message.create!(chat: chat4, sender: users[:octoling], recipient: users[:kirby], body: "Nos vemos en el lobby Kirby?")
Message.create!(chat: chat4, sender: users[:kirby], recipient: users[:octoling], body: "Poyoooooo!")
