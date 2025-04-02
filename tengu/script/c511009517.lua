--覇王眷竜 クリアウィング (Anime)
--Supreme King Dragon Clear Wing (Anime)
function c511009517.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_DARK),1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_EXTRA|LOCATION_GRAVE)
	e1:SetCondition(c511009517.spcon)
	e1:SetOperation(c511009517.spop)
	c:RegisterEffect(e1)
	--spsummon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009517(c511009517,1))
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511009517.distg)
	e2:SetOperation(c511009517.disop)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c511009517.atlimit)
	c:RegisterEffect(e3)
	--Destroy and damage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc511009517(c511009517,2))
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c511009517.descon)
	e4:SetTarget(c511009517.destg)
	e4:SetOperation(c511009517.desop)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc511009517(c511009517,3))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetHintTiming(0,TIMING_END_PHASE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c511009517.spcost)
	e5:SetTarget(c511009517.sptg)
	e5:SetOperation(c511009517.spop2)
	c:RegisterEffect(e5)
end
c511009517.listed_series={SET_SUPREME_KING_DRAGON}
c511009517.listed_names={13331639}
function c511009517.spfilter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_SYNCHRO) and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c511009517.cfilter(c)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009517.rescon(sg,e,tp,mg)
	local c=e:GetHandler()
	if c:IsLocation(LOCATION_EXTRA) then
		return Duel.GetLocationCountFromEx(tp,tp,sg,c)>0
	else
		return aux.ChkfMMZ(1)(sg,e,tp,mg)
	end
end
function c511009517.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eff={c:GetCardEffect(EFFECT_NECRO_VALLEY)}
	for _,te in ipairs(eff) do
		local op=te:GetOperation()
		if not op or op(e,c) then return false end
	end
	local g=Duel.GetReleaseGroup(tp):Filter(Card.IsSetCard,nil,SET_SUPREME_KING_DRAGON)
	local pg=aux.GetMustBeMaterialGroup(tp,Group.CreateGroup(),tp,nil,nil,REASON_SYNCHRO)
	return #pg<=0 and eg:IsExists(c511009517.spfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c511009517.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and #g>1 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,true)
		and aux.SelectUnselectGroup(g,e,tp,2,2,c511009517.rescon,0)
end
function c511009517.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetReleaseGroup(tp):Filter(Card.IsSetCard,nil,SET_SUPREME_KING_DRAGON)
	local pg=aux.GetMustBeMaterialGroup(tp,Group.CreateGroup(),tp,nil,nil,REASON_SYNCHRO)
	if #pg<=0 and #g>1 and aux.SelectUnselectGroup(g,e,tp,2,2,c511009517.rescon,0)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,true)
		and Duel.SelectEffectYesNo(tp,c,aux.Stringc511009517(c511009517,0)) then
		local sg=aux.SelectUnselectGroup(g,e,tp,2,2,c511009517.rescon,1,tp,HINTMSG_RELEASE)
		Duel.Release(sg,REASON_COST)
		Duel.SpecialSummon(c,SUMMON_TYPE_SYNCHRO,tp,tp,false,true,POS_FACEUP)
		c:CompleteProcedure()
	end
end
function c511009517.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsNegatableMonster,tp,0,LOCATION_MZONE,1,nil) end
end
function c511009517.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsNegatableMonster,tp,0,LOCATION_MZONE,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.AdjustInstantly(c)
	Duel.Destroy(g,REASON_EFFECT)
end
function c511009517.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c~=e:GetHandler()
end
function c511009517.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsControler(1-tp)
end
function c511009517.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chkc then return chkc==bc end
	if chk==0 then
		if c:IsHasEffect(c511009517+1) then return true
		else return bc and bc:IsOnField() and bc:IsCanBeEffectTarget(e) end
	end
	if c:IsHasEffect(c511009517+1) then
		e:SetProperty(0)
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	else
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.SetTargetCard(bc)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,bc:GetAttack())
	end
end
function c511009517.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sum=0
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	if not Duel.NegateAttack() then return end
	if c:IsHasEffect(c511009517+1) then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		if Duel.Destroy(g,REASON_EFFECT)>0 then
			local dg=Duel.GetOperatedGroup():Filter(Card.IsPreviousPosition,nil,POS_FACEUP)
			sum=dg:GetSum(Card.GetAttack)
		end
	else
		local tc=Duel.GetFirstTarget()
		if not tc or not tc:IsRelateToEffect(e) or Duel.Destroy(tc,REASON_EFFECT)==0 then return end
		if tc:IsPreviousPosition(POS_FACEUP) then
			sum=tc:GetPreviousAttackOnField()
		end
	end
	Duel.Damage(1-tp,sum,REASON_EFFECT)
end
function c511009517.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function c511009517.spfilter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(SET_SUPREME_KING_DRAGON) and c:IsType(TYPE_PENDULUM)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,e:GetHandler(),c)>1
end
function c511009517.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) and aux.CheckSummonGate(tp,2)
		and Duel.IsExistingMatchingCard(c511009517.spfilter2,tp,LOCATION_EXTRA,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end
function c511009517.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511009517.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) or not aux.CheckSummonGate(tp,2) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009517.spfilter2,tp,LOCATION_EXTRA,0,2,2,nil,e,tp)
	if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		for tc in aux.Next(Duel.GetMatchingGroup(c511009517.filter,tp,0,LOCATION_MZONE,nil)) do
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_ATTACK_FINAL)
			e2:SetValue(0)
			e2:SetReset(RESET_EVENT|RESETS_STANDARD)
			tc:RegisterEffect(e2)
		end
	end
end