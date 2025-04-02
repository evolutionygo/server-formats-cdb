--ダーク・ヒーロー ゾンバイア
--Zombyra the Dark (GOAT)
--Activation timing
function c504700152.initial_effect(c)
	--cannot direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c504700152.condition)
	e2:SetOperation(c504700152.atkop)
	c:RegisterEffect(e2)
end
function c504700152.condition(e,tp,eg,ep,ev,re,r,rp)
	local other=e:GetHandler():GetBattleTarget()
	return other and other:IsBattleDestroyed()
end
function c504700152.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-200)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
	c:RegisterEffect(e1)
end