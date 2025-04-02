--銀河眼の光子竜 (Anime)
--Galaxy-Eyes Photon Dragon (Anime)
--Scripted by the Razgriz
function c511003205.initial_effect(c)
	c:EnableReviveLimit()
	--Special Summon Procedure
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511003205.spcon)
	e1:SetTarget(c511003205.sptg)
	e1:SetOperation(c511003205.spop)
	c:RegisterEffect(e1)
	--Remove from play/Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511003205(c511003205,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(TIMING_BATTLE_PHASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511003205.rmcon)
	e2:SetTarget(c511003205.rmtg)
	e2:SetOperation(c511003205.rmop)
	c:RegisterEffect(e2)
end
function c511003205.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),Card.IsAttackAbove,2,false,2,true,c,c:GetControler(),nil,false,nil,2000)
end
function c511003205.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,Card.IsAttackAbove,2,2,false,true,true,c,nil,nil,false,nil,2000)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c511003205.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end
function c511003205.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511003205.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsOnField() and bc:IsCanBeEffectTarget(e) and c:IsAbleToRemove() and bc:IsAbleToRemove() end
	Duel.SetTargetCard(bc)
	local g=Group.FromCards(c,bc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c511003205.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local xg=tc:GetOverlayGroup()
	local g=Group.FromCards(c,tc)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup():Filter(Card.IsLocation,nil,LOCATION_REMOVED)
		if #og==0 then return end
		local mcount=xg:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
		for oc in aux.Next(og) do
			oc:RegisterFlagEffect(c511003205,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE,0,1)
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		e1:SetCountLimit(1)
		e1:SetLabel(mcount)
		e1:SetLabelObject(og)
		e1:SetOperation(c511003205.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511003205.retfilter(c)
	return c:GetFlagEffect(c511003205)~=0
end
function c511003205.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c511003205.retfilter,nil)
	g:DeleteGroup()
	for tc in sg:Iter() do
		if Duel.SpecialSummon(tc,0,tc:GetControler(),tc:GetControler(),false,false,POS_FACEUP)>0 and tc:IsFaceup() and tc==e:GetOwner() then
			local e1=Effect.CreateEffect(e:GetOwner())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
			e1:SetValue(e:GetLabel()*500)
			e:GetOwner():RegisterEffect(e1)
		end
	end
end