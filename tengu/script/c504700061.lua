--インセクト・プリンセス
--Insect Princess (GOAT)
--Activation timing
function c504700061.initial_effect(c)
	--Pos Change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_POSITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c504700061.target)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c504700061.condition)
	e2:SetOperation(c504700061.atkop)
	c:RegisterEffect(e2)
end
function c504700061.condition(e,tp,eg,ep,ev,re,r,rp)
	local other=e:GetHandler():GetBattleTarget()
	return other and other:IsBattleDestroyed() and other:IsRace(RACE_INSECT)
end
function c504700061.target(e,c)
	return c:IsRace(RACE_INSECT)
end
function c504700061.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
	c:RegisterEffect(e1)
end