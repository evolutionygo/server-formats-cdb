--王者の調和
--King's Synchro (Anime)
function c511003072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511003072.condition)
	e1:SetTarget(c511003072.target)
	e1:SetOperation(c511003072.activate)
	c:RegisterEffect(e1)
end
function c511003072.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsControler(tp) and tc:IsFaceup() and tc:IsType(TYPE_SYNCHRO)
end
function c511003072.filter(c,tp,tc)
	return c:IsType(TYPE_TUNER) and Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,Group.FromCards(c,tc))
end
function c511003072.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttackTarget()
	if chkc then return chkc==tc end
	if chk==0 then return tc and tc:IsCanBeEffectTarget(e) and Duel.IsExistingTarget(c511003072.filter,tp,LOCATION_GRAVE,0,1,nil,tp,tc) end
	Duel.SetTargetCard(tc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	Duel.SelectTarget(tp,c511003072.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp,tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511003072.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateAttack() then return end
	local tg=Duel.GetTargetCards(e)
	if #tg>0 then
		local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,nil,tg)
		if #g>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Synchro.Send=2
			Duel.SynchroSummon(tp,sg:GetFirst(),nil,tg)
		end
	end
end