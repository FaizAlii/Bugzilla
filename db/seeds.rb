# frozen_string_literal: true

Role.destroy_all

Role.create!([{
               name: 'Manager'
             },
              {
                name: 'QA'
              },
              {
                name: 'Developer'
              }])
