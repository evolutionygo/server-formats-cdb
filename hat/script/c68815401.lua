--クレイジー・ファイヤー
--Wild Fire
function c68815401.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCost(c68815401.cost)
	e1:SetTarget(c68815401.target)
	e1:SetOperation(c68815401.activate)
	c:RegisterEffect(e1)
end
c68815401.listed_names={68815402}
c68815401.listed_series={0xb9}
function c68815401.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) and Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 end
	Duel.PayLPCost(tp,500)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c68815401.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,0xb9),tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c68815401+1,0,TYPES_TOKEN,1000,1000,3,RACE_PYRO,ATTRIBUTE_FIRE) end
	local dg1=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,0xb9),tp,LOCATION_ONFIELD,0,nil)
	local dg2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	dg1:Merge(dg2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg1,#dg1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c68815401.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg1=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,0xb9),tp,LOCATION_ONFIELD,0,nil)
	if Duel.Destroy(dg1,REASON_EFFECT)>0 then
		local dg2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if Duel.Destroy(dg2,REASON_EFFECT)>0
			and Duel.IsPlayerCanSpecialSummonMonster(tp,c68815401+1,0,TYPES_TOKEN,1000,1000,3,RACE_PYRO,ATTRIBUTE_FIRE) then
			Duel.BreakEffect()
			local token=Duel.CreateToken(tp,c68815401+1)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
	end
end