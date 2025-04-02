--瞬間融合
--Flash Fusion (anime)
function c100000471.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff(c,nil,Fusion.OnFieldMat,nil,nil,nil,c100000471.stage2)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	c:RegisterEffect(e1)
end
function c100000471.stage2(e,tc,tp,sg,chk)
	if chk==1 then
		local fc100000471=e:GetHandler():GetFieldID()
		tc:RegisterFlagEffect(c100000471,RESET_EVENT+RESETS_STANDARD,0,1,fc100000471)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetLabel(fc100000471)
		e1:SetLabelObject(tc)
		e1:SetCondition(c100000471.tdcon)
		e1:SetOperation(c100000471.tdop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c100000471.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000471.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetFlagEffect(c100000471)>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end