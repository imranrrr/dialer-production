# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pp root_group = Group.create(group: 'root group' , group_description: 'Default Root group description')

pp new_users = Group.create(parent: root_group, group: 'NewUsers' , group_description: 'Default group for new users')

pp toshkent = Group.create(parent: root_group, group: 'Toshkent' , group_description: 'Toshkent Departament')
  pp Group.create(parent: toshkent, group: 'Chig’atoy' , group_description: 'Chig’atoy branch')
  pp Group.create(parent: toshkent, group: 'Algaritm' , group_description: 'Algaritm branch')
  pp Group.create(parent: toshkent, group: 'Bektemir' , group_description: 'Bektemir branch')

pp Group.create(parent: root_group, group: 'Qorasuv' , group_description: 'Qorasuv Departament ')
pp Group.create(parent: root_group, group: 'Orikzor' , group_description: 'Orikzor Departament')
pp Group.create(parent: root_group, group: 'Chirchiq' , group_description: 'Chirchiq Departament')

pp qibray = Group.create(parent: root_group, group: 'Qibray' , group_description: 'Qibray Departament')
pp maydon =  Group.create(parent: qibray, group: 'Maydon' , group_description: 'Maydon branch')

pp Group.create(parent: root_group, group: 'IOM' , group_description: 'IOM Departament ')
pp Group.create(parent: root_group, group: 'JHU' , group_description: 'JHU Departament ')
pp Group.create(parent: root_group, group: 'Markaziy baza' , group_description: 'Markaziy baza Departament')

pp andijon = Group.create(parent: root_group, group: 'Andijon' , group_description: 'Andijon Departament')
  pp Group.create(parent: andijon, group: 'Qoqon' , group_description: 'Qoqon branch')
  pp Group.create(parent: andijon, group: 'Kirgiliy OM' , group_description: 'Kirgiliy OM branch')
  
pp Group.create(parent: root_group, group: 'Fargona' , group_description: 'Fargona Departament')
pp Group.create(parent: root_group, group: 'Namangan' , group_description: 'Namangan Departament')
pp Group.create(parent: root_group, group: 'Tosh viloyati' , group_description: 'Tosh viloyati Departament')
pp Group.create(parent: root_group, group: 'Sirdaryo' , group_description: 'Sirdaryo Departament')

pp jizzah = Group.create(parent: root_group, group: 'Jizzah' , group_description: 'Jizzah Departament')
  pp Group.create(parent: jizzah, group: 'Dashtobod OM' , group_description: 'Dashtobod OM branch')

pp samarqand = Group.create(parent: root_group, group: 'Samarqand' , group_description: 'Samarqand Departament')
  pp Group.create(parent: samarqand, group: 'Bog’izag’on' , group_description: 'Bog’izag’on branch')

pp Group.create(parent: root_group, group: 'Buhoro' , group_description: 'Buhoro Departament')
pp Group.create(parent: root_group, group: 'Navoiy' , group_description: 'Navoiy Departament')
pp Group.create(parent: root_group, group: 'Qashqadaryo' , group_description: 'Qashqadaryo Departament')
pp Group.create(parent: root_group, group: 'Surhondaryo' , group_description: 'Surhondaryo Departament')
pp horazm = Group.create(parent: root_group, group: 'Horazm' , group_description: 'Horazm Departament')

pp qoraqalpoq = Group.create(parent: root_group, group: 'Qoraqalpoq' , group_description: 'Qoraqalpoq Departament')
pp nukus =  Group.create(parent: qoraqalpoq, group: 'Nukus OM' , group_description: 'Nukus OM branch')

pp nobody = Role.create(role: 'nobody', role_description: 'Никто Nobody')
pp sysadmin = Role.create(role: 'sysadmin', role_description: 'Системный Администратор / Sysadmin')
pp central = Role.create(role: 'central', role_description: 'Центральный аппарат /Central Administration')
pp departament = Role.create(role: 'departament', role_description: 'Департамент / Departament (3 смены)')
pp branch = Role.create(role: 'branch', role_description: 'Отдел / Branch')
pp duty = Role.create(role: 'moderator', role_description: 'Дежурный/ Duty ')
pp jeton = Role.create(role: 'jeton', role_description: 'Служащий/ Jeton ')

# Sysadmin
pp rules = []
pp rules << log_reader = Rule.create(rule: 'log_reader', rule_description: 'Просмотр логов / Log View')
pp rules << cdr_reader = Rule.create(rule: 'cdr_reader', rule_description: 'Просмотр звонков / CDR View')
pp rules << sound_recorder = Rule.create(rule: 'sound_recorder', rule_description: 'Запись звука / Sound Play')
pp rules << sound_listener = Rule.create(rule: 'sound_listener', rule_description: 'Прослушивание звука / Sound Play')
pp rules << show_basic_report = Rule.create(rule: 'show_basic_report', rule_description: 'Просмотр основного отчета / Basic report view')
pp rules << show_unpined_report = Rule.create(rule: 'show_unpined_report', rule_description: 'Просмотр без пина / Call without pin view')
pp rules << show_common_report = Rule.create(rule: 'show_common_report', rule_description: 'Просмотр общего отчета / Common report view')

pp rules << show_group = Rule.create(rule: 'show_group', rule_description: 'Показ группы / Show Group')
pp rules << add_group = Rule.create(rule: 'add_group', rule_description: 'Добавление группы / Add Group')
pp rules << edit_group = Rule.create(rule: 'edit_group', rule_description: 'Редактирование группы / Edit Group')
pp rules << delete_group = Rule.create(rule: 'delete_group', rule_description: 'Удаление группы / Delete Group')

pp rules << show_user = Rule.create(rule: 'show_user', rule_description: 'Показ служащего / Show User')
pp rules << add_user = Rule.create(rule: 'add_user', rule_description: 'Добавление служащего / Add User')
pp rules << edit_user = Rule.create(rule: 'edit_user', rule_description: 'Редактирование служащего / Edit User')
pp rules << delete_user = Rule.create(rule: 'delete_user', rule_description: 'Удаление служащего / Delete User')

pp rules << show_dial = Rule.create(rule: 'show_dial', rule_description: 'Показ обзвона / Show Dial')
pp rules << add_dial = Rule.create(rule: 'add_dial', rule_description: 'Добавление обзвона / Add Dial')
pp rules << edit_dial = Rule.create(rule: 'edit_dial', rule_description: 'Редактирование обзвона / Edit Dial')
pp rules << delete_dial = Rule.create(rule: 'delete_dial', rule_description: 'Удаление обзвона / Delete Dial')
pp rules << dial_runner = Rule.create(rule: 'dial_runner', rule_description: 'Запуск обзвона / Dial Run')

pp rules << show_dial_group = Rule.create(rule: 'show_dial_group', rule_description: 'Показ групы обзвона / Show Dial Group')
pp rules << add_dial_group = Rule.create(rule: 'add_dial_group', rule_description: 'Добавление группы обзвона / Add Dial Group')
pp rules << edit_dial_group = Rule.create(rule: 'edit_dial_group', rule_description: 'Редактирование группы обзвона / Edit Dial Group')
pp rules << delete_dial_group = Rule.create(rule: 'delete_dial_group', rule_description: 'Удаление группы обзвона / Delete Dial Group')

pp rules << show_dial_user = Rule.create(rule: 'show_dial_user', rule_description: 'Показ пользователя обзвона / Show Dial User')
pp rules << add_dial_user = Rule.create(rule: 'add_dial_user', rule_description: 'Добавление пользователя обзвона / Add Dial User')
pp rules << edit_dial_user = Rule.create(rule: 'edit_dial_user', rule_description: 'Редактирование пользователя обзвона / Edit Dial User')
pp rules << delete_dial_user = Rule.create(rule: 'delete_dial_user', rule_description: 'Удаление пользователя обзвона / Delete Dial User')

pp rules << show_role = Rule.create(rule: 'show_role', rule_description: 'Показ правил / Show Role')
pp rules << add_role = Rule.create(rule: 'add_role', rule_description: 'Добавление правила / Add Role')
pp rules << edit_role = Rule.create(rule: 'edit_role', rule_description: 'Редактирование правила / Edit Role')
pp rules << delete_role = Rule.create(rule: 'delete_Role', rule_description: 'Удаление правила  / Delete Role')

pp rules << show_rule = Rule.create(rule: 'show_rule', rule_description: 'Показ правил / Show Rule')
pp rules << add_rule = Rule.create(rule: 'add_rule', rule_description: 'Добавление правила / Add Rule')
pp rules << edit_rule = Rule.create(rule: 'edit_rule', rule_description: 'Редактирование правила / Edit Rule')
pp rules << delete_rule = Rule.create(rule: 'delete_rule', rule_description: 'Удаление правила  / Delete Rule')

pp rules << show_rule = Rule.create(rule: 'show_role_to_rule', rule_description: 'Показ правил к ролям / Show Rules to Roles')
pp rules << add_rule = Rule.create(rule: 'add_role_to_rule', rule_description: 'Добавление правил к ролям / Add Rule to Role')
pp rules << edit_rule = Rule.create(rule: 'edit_role_to_rule', rule_description: 'Редактирование правил к ролям / Edit Rule to Role')
pp rules << delete_rule = Rule.create(rule: 'delete_role_to_rule', rule_description: 'Удаление правил к ролям / Delete Rule to Role')

# Rolestorule rules to role sysadmin and central role
pp roles = []
pp roles << sysadmin
pp roles << central

roles.each do |role|
  rules.each do |rule|
    pp Rolestorule.create(role: role, rule: rule )
  end
end

# Rolestorule rules to departement role
pp remove = []
pp remove << log_reader

pp rules = rules - remove
pp rules

rules.each do |rule|
  pp Rolestorule.create(role: departament, rule: rule)
end

# Rolestorule rules to branch role
pp remove  << cdr_reader

pp rules = rules - remove
pp rules

rules.each do |rule|
  pp Rolestorule.create(role: branch, rule: rule)
end

# Rolestorule rules to branch role
pp remove << cdr_reader
pp rules = rules - remove
pp rules

rules.each do |rule|
  pp Rolestorule.create(role: duty, rule: rule)
end

pp User.create(phone: 998900050034, phone1: 998900050034, phone2: 998900050034,
fio: '1 User', rank: 'Polkovnik', group: root_group, role: sysadmin)

pp u = User.first
pp Dial.create(sound_url: "#{SecureRandom.uuid}", description: 'First test dial', user_id: u.id)
pp r = Record.create(description: "Test record", sound_url: "#{SecureRandom.uuid}")
pp d = Dial.create(sound_url: "#{SecureRandom.uuid}", description: 'Second test dial', user_id: u.id, record_id: r.id)
pp Dialstouser.create(user: u, dial: d)

pp g = Group.first
pp Dialstogroup.create(group: g, dial: d)

exit 

phone = 998111111111
user_num = 1
Group.all.each do |group|
  Role.all.each do |role|
    pp User.create(phone: phone.to_s,
    phone1: (phone + 1).to_s,
    phone2: (phone +2).to_s,
    fio: 'User' + user_num.to_s,
    rank: 'soldier',
    group: group,
    role: role)     
    phone += 10
    user_num += 1    
  end
end    

pp User.all.map{|user| user.update(pincode: rand(10-99))}
