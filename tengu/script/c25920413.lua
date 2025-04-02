--エーリアン・スカル
--Alien Skull
function c25920413.initial_effect(c)
	--special summon
	local e1=aux.AddLavaProcedure(c,1,POS_FACEUP,aux.AND(Card.IsFaceup,aux.FilterBoolFunction(Card.IsLevelBelow,3)),1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc25920413(c25920413,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c25920413.ctcon)
	e2:SetOperation(c25920413.ctop)
	c:RegisterEffect(e2)
	--atk def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c25920413.adcon)
	e3:SetTarget(c25920413.adtg)
	e3:SetValue(c25920413.adval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_SPSUMMON_COST)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCost(c25920413.spcost)
	e5:SetOperation(c25920413.spcop)
	c:RegisterEffect(e5)
end
c25920413.listed_series={0xc}
c25920413.counter_place_list={COUNTER_A}
function c25920413.spcost(e,c,tp,sumtype)
	return sumtype ~= SUMMON_TYPE_SPECIAL+1 or Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0
end
function c25920413.spcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
end
function c25920413.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c25920413.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		c:AddCounter(COUNTER_NEED_ENABLE+COUNTER_A,1)
	end
end
function c25920413.adcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c25920413.adtg(e,c)
	local bc=c:GetBattleTarget()
	return bc and c:GetCounter(COUNTER_A)~=0 and bc:IsSetCard(0xc)
end
function c25920413.adval(e,c)
	return c:GetCounter(COUNTER_A)*-300
end