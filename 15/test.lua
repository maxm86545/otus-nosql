fiber = require('fiber');
expirationd = require('expirationd')
client = require('http.client')

space = box.schema.space.create('test', { if_not_exists = true })
space:create_index('primary', { type = 'hash', parts = { 1, 'unsigned' }, if_not_exists = true })
space:create_index('status', { type = 'tree', parts = { 2, 'string' }, if_not_exists = true, unique = false })
space:truncate()

expirationd.start(
        'vps-stop',
        space.id,
        function(args, tuple)
            return tuple[2] == 'started' and tuple[3] <= 0
        end,
        {
            process_expired_tuple = function(spaceName, args, tuple)
                box.space[spaceName]:update({ tuple[1] }, { { '=', 2, 'stopped' } })
                fiber.create(
                        function()
                            client.get('http://nginx/?action=stop&user_id=' .. tuple[1])
                        end
                )
            end,
            args = nil,
            tuples_per_iteration = 50,
            full_scan_time = 3600,
            force = true
        }
)

space:insert { 1, 'stopped', 0, 1 }
space:insert { 2, 'started', 2, 1 }
space:insert { 3, 'started', 5, 1 }
space:insert { 4, 'started', 10, 1 }
space:insert { 5, 'started', 50, 2 }
space:insert { 6, 'stopped', 70, 1 }

space:select({})

for _ = 1, 10 do
    for _, tuple in space.index.status:pairs { 'started' } do
        space:update({ tuple[1] }, { { '-', 3, tuple[4] } })
    end
    fiber.sleep(1)
end

space:select({})
