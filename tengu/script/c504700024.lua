--墓守の使い魔
--Gravekeeper's Servant (GOAT)
--If the attacker is immune, cost is not pac504700024
function c504700024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ATTACK_COST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c504700024.atcon)
	e2:SetCost(c504700024.atcost)
	e2:SetOperation(c504700024.atop)
	c:RegisterEffect(e2)
	--accumulate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(c504700024)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	c:RegisterEffect(e3)
end
function c504700024.atcon(e)
	local c=Duel.GetAttacker()
	return not c or not c:IsImmuneToEffect(e)
end
function c504700024.atcost(e,c,tp)
	if c:IsImmuneToEffect(e) then return true end
	local ct=#{Duel.GetPlayerEffect(tp,c504700024)}
	return Duel.IsPlayerCanDiscardDeckAsCost(tp,ct)
end
function c504700024.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsAttackCostPac504700024()~=2 and e:GetHandler():IsLocation(LOCATION_SZONE) then
		Duel.DiscardDeck(tp,1,REASON_COST)
		Duel.AttackCostPac504700024()
	end
end