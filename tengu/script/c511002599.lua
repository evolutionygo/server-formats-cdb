--Ｎｏ．３９ 希望皇ホープ (Anime)
--Number 39: Utopia (Anime)
Duel.LoadCardScript("c84013237.lua")
function c511002599.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002599(c511002599,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002599.condition)
	e1:SetCost(c511002599.cost)
	e1:SetOperation(c511002599.operation)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e2)
end
c511002599.listed_series={SET_NUMBER}
c511002599.aux.xyz_number=39
function c511002599.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker() and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511002599.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002599.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end