--怒れるもけもけ
--Mokey Mokey Smackdown (GOAT)
--Battle destroyed registers while the mosnter is on field
function c504700005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--reg
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c504700005.regcon)
	e2:SetOperation(c504700005.regop)
	c:RegisterEffect(e2)
	local e2a=e2:Clone()
	e2a:SetCode(EVENT_BATTLED)
	e2a:SetCondition(c504700005.regcon2)
	c:RegisterEffect(e2a)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c504700005.atktg)
	e3:SetCondition(c504700005.atkcon)
	e3:SetValue(3000)
	c:RegisterEffect(e3)
end
c504700005.listed_names={27288416}
function c504700005.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousControler(tp) and c:IsRace(RACE_FAIRY)
end
function c504700005.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(c504700005)==0 and eg:IsExists(c504700005.cfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,27288416),tp,LOCATION_MZONE,0,1,nil)
end
function c504700005.cfilter2(c,tp)
	return c and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP)
		and c:IsControler(tp) and c:IsRace(RACE_FAIRY) and c:IsBattleDestroyed()
end
function c504700005.regcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(c504700005)==0 and (c504700005.cfilter2(Duel.GetAttacker(),tp) or c504700005.cfilter2(Duel.GetAttackTarget(),tp))
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,27288416),tp,LOCATION_MZONE,0,1,nil)
end
function c504700005.regop(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():RegisterFlagEffect(c504700005,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c504700005.atkcon(e)
	return e:GetHandler():GetFlagEffect(c504700005)~=0
end
function c504700005.atktg(e,c)
	return c:IsFaceup() and c:IsCode(27288416)
end