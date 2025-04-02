--火炎鳥
--Firebird (GOAT)
--Battle destroyed registers while the mosnter is on field
function c504700151.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700151(c504700151,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c504700151.atkcon)
	e1:SetTarget(c504700151.atktg)
	e1:SetOperation(c504700151.atkop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c504700151.atkcon)
	c:RegisterEffect(e2)
end
function c504700151.cfilter(c,tp)
	return not c:IsBattleDestroyed() and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and (c:GetPreviousRaceOnField()&RACE_WINGEDBEAST)~=0
end
function c504700151.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c504700151.cfilter,1,nil,tp)
end
function c504700151.cfilter2(c,tp)
	return c and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP)
		and c:IsControler(tp) and c:IsRace(RACE_WINGEDBEAST) and c:IsBattleDestroyed()
end
function c504700151.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	return c504700151.cfilter2(Duel.GetAttacker()) or c504700151.cfilter2(Duel.GetAttackTarget())
end
function c504700151.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() end
end
function c504700151.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	end
end