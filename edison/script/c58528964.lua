--フレイム・ゴースト
--Flame Ghost
function c58528964.initial_effect(c)
	--Must be properly summoned before reviving
	c:EnableReviveLimit()
	--Fusion summon procedure
	aux.AddFusionProcCode2(c,true,true,CARD_SKULL_SERVANT,40826495)
end
c58528964.listed_names={CARD_SKULL_SERVANT}