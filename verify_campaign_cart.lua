-- The real packaged cart and loader allow optional Gen 3 mods after its pins.
local F = assert(loadfile('../porting/native/campaign_fixture.lua'))({
  ['mods/qol_cart_probe/manifest.json'] = [[{"id":"qol_cart_probe","name":"Cart probe","version":"1.0.0","api":2,"entry":"main.lua","profile":"content","games":["gen3"],"priority":-100,"affects_link":false}]],
  ['mods/qol_cart_probe/main.lua'] = [[return function(mod)
    mod.exports.ready = true
    mod.hooks:wrap('ui.start_menu.items', function(next, game, items)
      local out = next(game, items)
      out[#out + 1] = {id='qol_cart_probe',label='EXTRA MOD'}
      return out
    end)
  end]],
})
local T = F.T
local report = F.loader:cartStatus()
T.eq(report.seal, 'open', 'packaged cart is open')
T.eq(report.enforced, false, 'additional mods are permitted')
T.eq(F.loader.order[1], 'g3_campaign', 'campaign stays first')
T.eq(F.loader.order[2], 'g3_coop', 'co-op stays second')
T.eq(F.loader.order[3], 'qol_cart_probe', 'extra mod loads after pins even with a lower priority')
T.check(F.loader.exports.qol_cart_probe.ready, 'the extra mod executes')
local items = require('src.mods.Runtime').call('ui.start_menu.items', function(_, list) return list end,
  {phase='field'}, {{id='bag',label='BAG'}, {id='save',label='SAVE'}, {id='exit',label='EXIT'}})
local seen = {}
for _, item in ipairs(items) do seen[item.id] = true end
T.check(seen.g3_campaign_candy, 'Rare Candy survives the extra mod hook')
T.check(seen.g3_campaign_repel, 'Repel survives the extra mod hook')
T.check(seen.qol_cart_probe, 'the additional mod can extend the menu')
T.eq(F.loader.modOptions.g3_coop.soullink, true, 'cart still supplies Soul Link defaults')
T.eq(F.loader.modOptions.g3_coop.sl_caps, true, 'cart still supplies level cap defaults')
T.finish('campaign open cart')
