--ジェムナイト・ジルコニア
function c8692301.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,0x1047),aux.FilterBoolFunctionEx(Card.IsRace,RACE_ROCK))
end
c8692301.material_setcode={0x47,0x1047}