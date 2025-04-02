--アゲインスト・ウィンド (Action Card)
--Against the Wind (Action Card)
--Scripted by Larry126
function c150000077.initial_effect(c)
	--Change all monsters your opponent controls to Defense Position and decrease their DEF by 1000
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc150000077(c150000077,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER)
	e1:SetCondition(c150000077.condition)
	e1:SetTarget(c150000077.target)
	e1:SetOperation(c150000077.activate)
	c:RegisterEffect(e1)
end
function c150000077.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c150000077.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c150000077.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c150000077.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c150000077.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,#g,tp,POS_FACEUP_DEFENSE)
	Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,g,#g,1-tp,-1000)
end
function c150000077.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c150000077.filter,tp,0,LOCATION_MZONE,nil)
	if #g>0 and Duel.ChangePosition(g,POS_FACEUP_DEFENSE)>0 then
		local tg=Duel.GetOperatedGroup()
		local c=e:GetHandler()
		--Decrease their DEF by 1000
		for tc in tg:Iter() do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_DEFENSE)
			e1:SetValue(-1000)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end