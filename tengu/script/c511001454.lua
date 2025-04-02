--D/D Necro Slime (anime)
--rescripted by Naim
function c511001454.initial_effect(c)
	--spsummon
	local params = {aux.FilterBoolFunction(Card.IsSetCard,0x10af),Fusion.OnFieldMat}
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(Fusion.SummonEffTG(table.unpack(params)))
	e1:SetOperation(Fusion.SummonEffOP(table.unpack(params)))
	c:RegisterEffect(e1)
end
c511001454.listed_series={0x10af}