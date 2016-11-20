

$timestamp = generate('/bin/date', '+%Y-%d-%m %H:%M:%S')

notify { 'agent_message':
        name => agent_message,
        message => "Agent run starting at $timestamp",

}
