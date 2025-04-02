--フュージョン・ゲート
--Fusion Gate
function c33550694.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--fusion
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc33550694(c33550694,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetTarget(Fusion.SummonEffTG(nil,Card.IsAbleToRemove,nil,Fusion.BanishMaterial))
	e2:SetOperation(Fusion.SummonEffOP(nil,Card.IsAbleToRemove,nil,Fusion.BanishMaterial))
	c:RegisterEffect(e2)
end